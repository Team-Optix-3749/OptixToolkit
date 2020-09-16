import mongoose, { Schema, Document } from 'mongoose';
import { MONGO_URL } from './config';

mongoose.connect(MONGO_URL, { useNewUrlParser: true });

export interface Tool extends Document {
  title: string;
  dates: Date[];
}

const ToolSchema: Schema = new Schema({
  title: { type: String, required: true },
  dates: { type: [Date], required: true },
});

const tools = mongoose.model<Tool>('tools', ToolSchema) 

export { tools }